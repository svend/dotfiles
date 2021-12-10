#homeMod: {
	_key: string
	_mod: string
	from: {
		key_code: _key
		modifiers: optional: ["any"]
	}
	to: [{
		key_code: _mod
		lazy:     true
	}]
	to_if_alone: [{
		key_code: _key
	}]
	type: "basic"
}

global: {
	check_for_updates_on_startup:  true
	show_in_menu_bar:              true
	show_profile_name_in_menu_bar: false
}
profiles: [{
	complex_modifications: {
		parameters: {
			"basic.simultaneous_threshold_milliseconds":    50
			"basic.to_delayed_action_delay_milliseconds":   500
			"basic.to_if_alone_timeout_milliseconds":       200
			"basic.to_if_held_down_threshold_milliseconds": 500
			"mouse_motion_to_scroll.speed":                 100
		}
		rules: [{
			description: "Home row modifier keys"
			manipulators: [
				#homeMod & {_key: "a", _mod:         "left_command"},
				#homeMod & {_key: "semicolon", _mod: "right_command"},
				#homeMod & {_key: "s", _mod:         "left_alt"},
				#homeMod & {_key: "l", _mod:         "right_alt"},
				#homeMod & {_key: "d", _mod:         "left_control"},
				#homeMod & {_key: "k", _mod:         "right_control"},
				#homeMod & {_key: "f", _mod:         "left_shift"},
				#homeMod & {_key: "j", _mod:         "right_shift"},
			]
		}, {
			description: "Firefox: C-n -> down arrow"
			manipulators: [{
				conditions: [{
					bundle_identifiers: ["^org\\.mozilla\\.firefox$"]
					type: "frontmost_application_if"
				}]
				from: {
					key_code: "n"
					modifiers: mandatory: ["control"]
				}
				to: [{
					key_code: "down_arrow"
					modifiers: []
				}]
				type: "basic"
			}]
		}, {
			description: "Firefox: C-p -> up arrow"
			manipulators: [{
				conditions: [{
					bundle_identifiers: ["^org\\.mozilla\\.firefox$"]
					type: "frontmost_application_if"
				}]
				from: {
					key_code: "p"
					modifiers: mandatory: ["control"]
				}
				to: [{
					key_code: "up_arrow"
					modifiers: []
				}]
				type: "basic"
			}]
		}, {
			description: "Command+Option+L to Lock Screen (macOS 10.13+)"
			manipulators: [{
				from: {
					key_code: "l"
					modifiers: mandatory: ["command", "option"]
				}
				to: [{
					key_code: "q"
					modifiers: ["left_control", "left_command"]
				}]
				type: "basic"
			}]
		}]
	}
	devices: [{
		disable_built_in_keyboard_if_exists: false
		fn_function_keys: []
		identifiers: {
			is_keyboard:        true
			is_pointing_device: false
			product_id:         24647
			vendor_id:          6127
		}
		ignore:                   false
		manipulate_caps_lock_led: false
		simple_modifications: [{
			from: key_code: "left_command"
			to: [{
				key_code: "left_command"
			}]
		}, {
			from: key_code: "left_option"
			to: [{
				key_code: "left_option"
			}]
		}, {
			from: key_code: "right_command"
			to: [{
				key_code: "right_command"
			}]
		}, {
			from: key_code: "right_option"
			to: [{
				key_code: "right_option"
			}]
		}]
	}, {
		disable_built_in_keyboard_if_exists: false
		fn_function_keys: []
		identifiers: {
			is_keyboard:        false
			is_pointing_device: true
			product_id:         24647
			vendor_id:          6127
		}
		ignore:                   false
		manipulate_caps_lock_led: false
		simple_modifications: []
	}, {
		disable_built_in_keyboard_if_exists: false
		fn_function_keys: []
		identifiers: {
			is_keyboard:        true
			is_pointing_device: false
			product_id:         8195
			vendor_id:          16700
		}
		ignore:                   false
		manipulate_caps_lock_led: false
		simple_modifications: [{
			from: key_code: "left_control"
			to: [{
				key_code: "left_command"
			}]
		}, {
			from: key_code: "right_control"
			to: [{
				key_code: "right_command"
			}]
		}]
	}, {
		disable_built_in_keyboard_if_exists: false
		fn_function_keys: []
		identifiers: {
			is_keyboard:        true
			is_pointing_device: false
			product_id:         635
			vendor_id:          1452
		}
		ignore:                   false
		manipulate_caps_lock_led: true
		simple_modifications: [{
			from: key_code: "left_command"
			to: [{
				key_code: "left_option"
			}]
		}, {
			from: key_code: "left_option"
			to: [{
				key_code: "left_command"
			}]
		}, {
			from: key_code: "right_command"
			to: [{
				key_code: "right_option"
			}]
		}, {
			from: key_code: "right_option"
			to: [{
				key_code: "right_command"
			}]
		}]
	}, {
		disable_built_in_keyboard_if_exists: false
		fn_function_keys: []
		identifiers: {
			is_keyboard:        true
			is_pointing_device: false
			product_id:         32
			vendor_id:          3727
		}
		ignore:                   false
		manipulate_caps_lock_led: false
		simple_modifications: [{
			from: key_code: "left_control"
			to: [{
				key_code: "left_command"
			}]
		}, {
			from: key_code: "right_control"
			to: [{
				key_code: "right_command"
			}]
		}]
	}, {
		disable_built_in_keyboard_if_exists: false
		fn_function_keys: []
		identifiers: {
			is_keyboard:        false
			is_pointing_device: true
			product_id:         50184
			vendor_id:          1133
		}
		ignore:                   true
		manipulate_caps_lock_led: false
		simple_modifications: []
	}]
	fn_function_keys: [{
		from: key_code: "f1"
		to: [{
			key_code: "display_brightness_decrement"
		}]
	}, {
		from: key_code: "f2"
		to: [{
			key_code: "display_brightness_increment"
		}]
	}, {
		from: key_code: "f3"
		to: [{
			key_code: "mission_control"
		}]
	}, {
		from: key_code: "f4"
		to: [{
			key_code: "launchpad"
		}]
	}, {
		from: key_code: "f5"
		to: [{
			key_code: "illumination_decrement"
		}]
	}, {
		from: key_code: "f6"
		to: [{
			key_code: "illumination_increment"
		}]
	}, {
		from: key_code: "f7"
		to: [{
			key_code: "rewind"
		}]
	}, {
		from: key_code: "f8"
		to: [{
			key_code: "play_or_pause"
		}]
	}, {
		from: key_code: "f9"
		to: [{
			key_code: "fastforward"
		}]
	}, {
		from: key_code: "f10"
		to: [{
			key_code: "mute"
		}]
	}, {
		from: key_code: "f11"
		to: [{
			key_code: "volume_decrement"
		}]
	}, {
		from: key_code: "f12"
		to: [{
			key_code: "volume_increment"
		}]
	}]
	name: "Default profile"
	parameters: delay_milliseconds_before_open_device: 1000
	selected: true
	simple_modifications: []
	virtual_hid_keyboard: {
		caps_lock_delay_milliseconds:        0
		country_code:                        0
		indicate_sticky_modifier_keys_state: true
		keyboard_type:                       "ansi"
		mouse_key_xy_scale:                  100
	}
}, {
	complex_modifications: {
		parameters: {
			"basic.simultaneous_threshold_milliseconds":    50
			"basic.to_delayed_action_delay_milliseconds":   500
			"basic.to_if_alone_timeout_milliseconds":       1000
			"basic.to_if_held_down_threshold_milliseconds": 500
			"mouse_motion_to_scroll.speed":                 100
		}
		rules: []
	}
	devices: []
	fn_function_keys: [{
		from: key_code: "f1"
		to: [{
			consumer_key_code: "display_brightness_decrement"
		}]
	}, {
		from: key_code: "f2"
		to: [{
			consumer_key_code: "display_brightness_increment"
		}]
	}, {
		from: key_code: "f3"
		to: [{
			apple_vendor_keyboard_key_code: "mission_control"
		}]
	}, {
		from: key_code: "f4"
		to: [{
			apple_vendor_keyboard_key_code: "spotlight"
		}]
	}, {
		from: key_code: "f5"
		to: [{
			consumer_key_code: "dictation"
		}]
	}, {
		from: key_code: "f6"
		to: [{
			key_code: "f6"
		}]
	}, {
		from: key_code: "f7"
		to: [{
			consumer_key_code: "rewind"
		}]
	}, {
		from: key_code: "f8"
		to: [{
			consumer_key_code: "play_or_pause"
		}]
	}, {
		from: key_code: "f9"
		to: [{
			consumer_key_code: "fast_forward"
		}]
	}, {
		from: key_code: "f10"
		to: [{
			consumer_key_code: "mute"
		}]
	}, {
		from: key_code: "f11"
		to: [{
			consumer_key_code: "volume_decrement"
		}]
	}, {
		from: key_code: "f12"
		to: [{
			consumer_key_code: "volume_increment"
		}]
	}]
	name: "Empty profile"
	parameters: delay_milliseconds_before_open_device: 1000
	selected: false
	simple_modifications: []
	virtual_hid_keyboard: {
		country_code:                        0
		indicate_sticky_modifier_keys_state: true
		mouse_key_xy_scale:                  100
	}
}]
