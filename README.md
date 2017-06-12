# HelpTextView

## Goals
- Simple UI for important, nonubstructive app info
- Multiple included themes that reflect different types of subtle notifications
- Singleton style in order to quickly activate the Help Text view
- Automatic support for all screen orientations

## Use
`public class func present(str: String, theme t: HelpTheme, withFadeDuration fadeDuration: TimeInterval, persistenceDuration: TimeInterval, animated: Bool)`
- `str`: the String to display
- `t`: the theme; HelpTheme.Warning, .Reminder, .Progress, .Detail, and .Custom(stroke: UIColor, fill: UIColor)
- `fadeDuration`: the time it takes for the view to fade in and out
- `persistenceDuration`: the time the view stays on screen after and before fade animations
- `animated`: 'true' if fade animation needed. **If 'false', the view must be animated off screen using the hide() function

## Included and Custom Themes
### .Warning
<img src="https://github.com/oalejel/Help-Text/blob/master/Readme%20Images/red.png" width="40%"></img>
### .Reminder
<img src="https://github.com/oalejel/Help-Text/blob/master/Readme%20Images/orange.png" width="40%"></img>
### .Progress
<img src="https://github.com/oalejel/Help-Text/blob/master/Readme%20Images/green.png" width="40%"></img>
### .Detail
<img src="https://github.com/oalejel/Help-Text/blob/master/Readme%20Images/black.png" width="40%"></img>
### An ugly example of .Custom(stroke: UIColor, fill: UIColor)
<img src="https://github.com/oalejel/Help-Text/blob/master/Readme%20Images/custom%20weird.png" width="40%"></img>

Partial Credit to SwiftSpinner for Singleton class format
