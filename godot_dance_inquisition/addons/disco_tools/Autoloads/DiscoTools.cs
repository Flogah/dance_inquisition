// Bridge heavily inspirted by GDM implementation
using Godot;
using Godot.Collections;
using System;

namespace DiscoToolsRuntime {

public enum EEventStatus { NOT_OFFERED, SUCCESS, FAILURE, OTHER }

public enum EMissionStatus {
    NOT_OFFERED,
    IN_PROGRESS,
    DENIED,
    SUCCESS,
    FAILURE,
    OTHER
}

#nullable enable

public partial class DiscoTools : RefCounted {
    public const String SAVE_PATH = "user://disco_state.save";
    public const String INIT_PATH = "user://disco_state_init.save";

    private static GodotObject? instance;
    public static GodotObject Instance {
        get {
            if (instance == null) {
                instance = Engine.GetSingleton("Disco");
                // Connect signals here
            }
            return instance;
        }
    }

    public static Resource State {
        get => (Resource)Instance.Get("state");
        set => Instance.Set("state", value);
    }
    // TODO: Full parameter parity

    public static void SaveState(String path = SAVE_PATH) {
        Instance.Call("save_state", path);
    }

    public static void LoadState(String path = SAVE_PATH) {
        Instance.Call("load_state", path);
    }

    public static bool Roll(CheckRes resource) {
        return (bool)Instance.Call("roll", resource);
    }

    public static int GetRollOdds(CheckRes resource) {
        return (int)Instance.Call("getRollOdds", resource);
    }

    // TODO: Full function parity

    public partial class DiscoRes : Resource {}
    public partial class CheckRes : DiscoRes {
        public string name { get; set; }

        public bool oneshot { get; set; }

        public int difficulty { get; set; }

        public Godot.Collections.Dictionary<string, ModifierRes>? modifiers {
            get; set;
        }

        public int attempts { get; set; }

        public bool locked { get; set; }

        public bool passed { get; set; }
        public CheckRes() : this("", null, false, 0) {}

        public CheckRes(
            string _name,
            Godot.Collections.Dictionary<string, ModifierRes>? modList,
            bool _oneshot, int _difficulty) {
            name = _name;
            modifiers = modList;
            difficulty = _difficulty;
            attempts = 0;
            locked = false;
            passed = false;
            oneshot = _oneshot;
        }
    }

    public partial class EventRes : DiscoRes {
        [Export]
        public string name { get; set; }

        // 0 for not offered yet,
        // 1 for success,
        // 2 for fail
        // 3 other (See statusstr)
        [Export]
        public int status {
            get; set;
        }

        [Export]
        public string statusStr {
            get; set;
        }

        public EventRes() : this("", 0, "") {}

        public EventRes(string _name, int _status, string _sstr) {
            name = _name;
            status = _status;
            statusStr = _sstr;
        }
    }
    public partial class MissionRes : DiscoRes {
        [Export]
        public string name { get; set; }

        [Export]
        public Godot.Collections.Dictionary<string, EventRes>? events {
            get; set;
        }

        // 0 for not offered yet,
        // 1 for in progress,
        // 2 for denied,
        // 3 for success,
        // 4 for fail
        [Export]
        public int status {
            get; set;
        }

        // Make sure you provide a parameterless constructor.
        // In C#, a parameterless constructor is different from a
        // constructor with all default values.
        // Without a parameterless constructor, Godot will have problems
        // creating and editing your resource via the inspector.
        public MissionRes() : this("", null, 0) {}

        public MissionRes(
            string _name,
            Godot.Collections.Dictionary<string, EventRes>? modList,
            int _status) {
            name = _name;
            events = modList;
            status = _status;
        }
    }
    public partial class ModifierRes : DiscoRes {
        [Export]
        public string name { get; set; }

        [Export]
        public int bonus {
            get; set;
        }

        [Export]
        public bool enabled {
            get; set;
        }

        // Make sure you provide a parameterless constructor.
        // In C#, a parameterless constructor is different from a
        // constructor with all default values.
        // Without a parameterless constructor, Godot will have problems
        // creating and editing your resource via the inspector.
        public ModifierRes() : this("", 0, false) {}

        public ModifierRes(string _name, int _bonus, bool _enabled) {
            name = _name;
            bonus = _bonus;
            enabled = _enabled;
        }
        public partial class NpcRes : DiscoRes {
            [Export]
            public string name { get; set; }

            [Export]
            public Resource? mainDialogue {
                get; set;
            }

            [Export]
            public Resource? fallbackDialogue {
                get; set;
            }

            [Export]
            public Resource? image {
                get; set;
            }

            [Export]
            public PackedScene? sprite {
                get; set;
            }

            [Export]
            public Godot.Collections.Dictionary<string, CheckRes>? checks {
                get; set;
            }

            [Export]
            public bool dialogueFinished;

            // Make sure you provide a parameterless constructor.
            // In C#, a parameterless constructor is different from a
            // constructor with all default values.
            // Without a parameterless constructor, Godot will have problems
            // creating and editing your resource via the inspector.
            public NpcRes()
                : this("", null, null, null, null,
                       new Godot.Collections.Dictionary<string, CheckRes>()) {}

            public NpcRes(
                string _name, Resource? _mainDia, Resource? _fallbackDia,
                Resource? _image, PackedScene? _sprite,
                Godot.Collections.Dictionary<string, CheckRes>? _checks) {
                name = _name;
                mainDialogue = _mainDia;
                fallbackDialogue = _fallbackDia;
                image = _image;
                sprite = _sprite;
                checks = _checks;
            }
        }
    }
}
}
