# CHANGELOG

## v0.1.3
- Added a "DeathZone" node to "Wall" scene, now when the player is stuck in a wall the game is over.
- In "Utils.gd"
    - Added "get_version" method
    - Added "get_separate_words_string" method
    - Added "simulate_input_pressed" method
- Added "Debug.gd"
    - on "_ready" mute audio is the version is development
- Added "Menu" for pause and "menu.gd"
- Added "selection_container.gd"
- Added "Settings" scene and "settings.gd"
    - Added "VolumeButton"
    - Added "InputButton"
- Added "InputMapper"
    - Added "input_button.gd"

## v0.1.2.1
- "AudioStreamPlayer.autoplay = true"

## v0.1.2
- Added labels for tutorials
    - in "TitleScreen" added "Move with A - D" label
    - in "Game" added "Press SPACE to jump" and "Beware the spikes!" labels
- The "VersionLabel" in "TitleScreen" corresponds to "application/config/version" of the config
- Added signal waves
- The signal will reach if "player.can_interact == true"

## v0.1.1
- Fixed the label "Press Q to propagate the signal" to "Hold Q to propagate the signal"
- "_notification" method moved from "game.gd" to "state_machine.gd"
    - when the window is unfocused/focused set get_tree().paused = true only when "state == PLAY"
- in "wall.gd"
    - changed node type from "StaticBody2D" to "AnimatableBody2D"
    - set as member "tween" and modified "_on_level_active_changed" method