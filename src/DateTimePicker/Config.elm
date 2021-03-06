module DateTimePicker.Config
    exposing
        ( Config
        , DatePickerConfig
        , TimePickerConfig
        , TimePickerType(..)
        , NameOfDays
        , Type(..)
        , defaultDatePickerConfig
        , defaultTimePickerConfig
        , defaultDateTimePickerConfig
        )

{-| DateTimePicker configuration

# Configuration
@docs Config, DatePickerConfig, TimePickerConfig, defaultDatePickerConfig, defaultTimePickerConfig, defaultDateTimePickerConfig, NameOfDays, TimePickerType, Type

-}

import Date exposing (Date)
import DateTimePicker.Internal exposing (InternalState)
import DateTimePicker.Formatter


type alias State =
    InternalState


{-| The type of picker (for Internal Use)
-}
type Type msg
    = DateType (Config (DatePickerConfig {}) msg)
    | DateTimeType (Config (DatePickerConfig TimePickerConfig) msg)
    | TimeType (Config TimePickerConfig msg)


{-| Configuration

 * `onChange` is the message for when the selected value and internal `State` in the date picker has changed.
 * `dateFormatter` is a Date to string formatter used to display the date in the input text
 * `dateTimeFormatter` is a Date to string formatter used to display the date in the footer section.
 * `autoClose` is a flag to indicate whether the dialog should be automatically closed when a date and/or time is selected.
 * `allowYearNavigation` show/hide year navigation button.
-}
type alias Config otherConfig msg =
    { otherConfig
        | onChange : State -> Maybe Date -> msg
        , dateFormatter : Date -> String
        , dateTimeFormatter : Date -> String
        , autoClose : Bool
        , allowYearNavigation : Bool
    }


{-| Configuration for the DatePicker

 * `nameOfDays` is the configuration for name of days in a week.
 * `firstDayOfWeek` is the first day of the week.
 * `formatter` is the Date to String formatter for the input value.
 * `titleFormatter` is the Date to String formatter for the dialog's title.
 * `fullDateFormatter` is the Date to String formatter for the dialog's footer.
 * `allowYearNavigation` show/hide year navigation button.
-}
type alias DatePickerConfig otherConfig =
    { otherConfig
        | nameOfDays : NameOfDays
        , firstDayOfWeek : Date.Day
        , titleFormatter : Date -> String
        , fullDateFormatter : Date -> String
    }


{-| Default configuration for DatePicker

 * `onChange` No Default
 * `dateFormatter` Default: `"%m/%d/%Y"`
 * `dateTimeFormatter` Default: `"%m/%d/%Y %I:%M %p"`
 * `autoClose` Default: True
 * `nameOfDays` see `NameOfDays` for the default values.
 * `firstDayOfWeek` Default: Sunday.
 * `titleFormatter`  Default: `"%B %Y"`
 * `fullDateFormatter` Default:  `"%A, %B %d, %Y"`
 * `allowYearNavigation` Default : True
-}
defaultDatePickerConfig : (State -> Maybe Date -> msg) -> Config (DatePickerConfig {}) msg
defaultDatePickerConfig onChange =
    { onChange = onChange
    , dateFormatter = DateTimePicker.Formatter.dateFormatter
    , dateTimeFormatter = DateTimePicker.Formatter.dateTimeFormatter
    , autoClose = True
    , nameOfDays = defaultNameOfDays
    , firstDayOfWeek = Date.Sun
    , titleFormatter = DateTimePicker.Formatter.titleFormatter
    , fullDateFormatter = DateTimePicker.Formatter.fullDateFormatter
    , allowYearNavigation = True
    }


{-| Configuration for TimePicker

 * `timeFormatter` is the time to String formatter.
 * `timePickerType` is the type of the time picker, either Analog or Digital
-}
type alias TimePickerConfig =
    { timeFormatter : Date -> String
    , timePickerType : TimePickerType
    }


{-| The type of time picker, can be either Digital or Analog
-}
type TimePickerType
    = Digital
    | Analog


{-| Default configuration for TimePicker
  * `onChange` No Default
  * `dateFormatter` Default: `"%m/%d/%Y"`
  * `dateTimeFormatter` Default: `"%m/%d/%Y %I:%M %p"`
  * `autoClose` Default: False
  * `timeFormatter` Default: `"%I:%M %p"`
  * `timePickerType` Default: Analog
  * `allowYearNavigation` Default : True
-}
defaultTimePickerConfig : (State -> Maybe Date -> msg) -> Config TimePickerConfig msg
defaultTimePickerConfig onChange =
    { onChange = onChange
    , dateFormatter = DateTimePicker.Formatter.dateFormatter
    , dateTimeFormatter = DateTimePicker.Formatter.dateTimeFormatter
    , autoClose = False
    , timeFormatter = DateTimePicker.Formatter.timeFormatter
    , timePickerType = Analog
    , allowYearNavigation = True
    }


{-| Default configuration for DateTimePicker

 * `onChange` No Default
 * `dateFormatter` Default: `"%m/%d/%Y"`
 * `dateTimeFormatter` Default: `"%m/%d/%Y %I:%M %p"`
 * `autoClose` Default: False
 * `nameOfDays` see `NameOfDays` for the default values.
 * `firstDayOfWeek` Default: Sunday.
 * `titleFormatter`  Default: `"%B %Y"`
 * `fullDateFormatter` Default:  `"%A, %B %d, %Y"`
 * `timeFormatter` Default: `"%I:%M %p"`
 * `timePickerType` Default:  Analog
 * `allowYearNavigation` Default : True
-}
defaultDateTimePickerConfig : (State -> Maybe Date -> msg) -> Config (DatePickerConfig TimePickerConfig) msg
defaultDateTimePickerConfig onChange =
    { onChange = onChange
    , dateFormatter = DateTimePicker.Formatter.dateFormatter
    , dateTimeFormatter = DateTimePicker.Formatter.dateTimeFormatter
    , autoClose = False
    , nameOfDays = defaultNameOfDays
    , firstDayOfWeek = Date.Sun
    , titleFormatter = DateTimePicker.Formatter.titleFormatter
    , fullDateFormatter = DateTimePicker.Formatter.fullDateFormatter
    , timeFormatter = DateTimePicker.Formatter.timeFormatter
    , timePickerType = Analog
    , allowYearNavigation = True
    }


{-| Configuration for name of days in a week.

This will be displayed as the calendar's header.
Default:
 * sunday = "Su"
 * monday = "Mo"
 * tuesday = "Tu"
 * wednesday = "We"
 * thursday = "Th"
 * friday = "Fr"
 * saturday = "Sa"
-}
type alias NameOfDays =
    { sunday : String
    , monday : String
    , tuesday : String
    , wednesday : String
    , thursday : String
    , friday : String
    , saturday : String
    }


defaultNameOfDays : NameOfDays
defaultNameOfDays =
    { sunday = "Su"
    , monday = "Mo"
    , tuesday = "Tu"
    , wednesday = "We"
    , thursday = "Th"
    , friday = "Fr"
    , saturday = "Sa"
    }
