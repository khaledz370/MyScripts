# Define input video file
$input = "input_video.mp4" # Replace with your input video file

# Define timestamps and titles
$chapters = @{
    "00:00:11" = "Presentation"
    "00:02:58" = "Developer Accounts"
    "00:39:12" = "Setup"
    "01:14:43" = "Introduction to Dart"
    "02:01:26" = "Dart control statements and collections"
    "02:46:45" = "Sound Null-safety in Dart"
    "03:27:12" = "Dart enumerations, classes and objects"
    "04:18:37" = "Advanced Dart"
    "05:00:40" = "Project setup"
    "05:48:30" = "iOS App Setup (App Identifier, Certificates and Profiles)"
    "06:59:33" = "Android app Setup"
    "07:31:32" = "Firebase Backend Setup"
    "08:01:21" = "Basic register-user screen"
    "09:04:54" = "Login view"
    "09:53:10" = "Separating app initialization from login/register"
    "10:19:48" = "Git and Github"
    "11:10:34" = "Email Verification View"
    "11:44:45" = "Link Between login and register views"
    "12:18:01" = "Logout view"
    "13:13:47" = "Go From Login to Notes View"
    "13:36:44" = "Cleaning Up our Routes"
    "13:51:17" = "Error Handling in Login View"
    "14:16:21" = "Error Handling in Register View and Going to Next Screen After Registration"
    "14:44:45" = "Confirming Identity Before Going to Main UI"
    "14:52:22" = "Auth Service"
    "15:55:22" = "Migrating to Auth Service"
    "16:33:41" = "Unit Testing our Auth Service"
    "17:43:43" = "CRUD Local Storage"
    "19:30:57" = "Working with Streams in Notes Service"
    "20:04:32" = "Preparing Notes View to Read All Notes"
    "20:39:22" = "Preparing to Create New Notes"
    "21:00:16" = "Creating New Notes"
    "21:35:43" = "Displaying Notes in Notes View"
    "21:56:04" = "Deleting Existing Notes in Notes View"
    "22:40:46" = "Updating Existing Notes"
    "23:14:12" = "Protecting NotesService with Current User"
    "23:40:44" = "Writing Notes to Cloud Firestore"
    "24:58:08" = "Migrating to our Firestore Service"
    "25:22:36" = "Sharing Notes"
    "25:37:44" = "Introduction to Bloc"
    "26:24:31" = "Converting our Auth Process to Bloc"
    "27:31:17" = "Handling Auth Bloc Exceptions During Login"
    "27:52:45" = "Moving to Bloc for Routing and Dialogs"
    "29:58:23" = "Loading Screens"
    "29:48:31" = "Final Touches Before App Release"
    "30:43:03" = "App Icons and app Name"
    "31:06:34" = "Splash Screen"
    "31:56:59" = "Sending our iOS app to App Store Connect"
    "32:55:44" = "Releasing our iOS App"
    "33:20:32" = "Fixing Firebase Security Rules and Resubmitting the iOS App"
    "34:50:07" = "Releasing our Android App"
    "34:55:19" = "Localization in Flutter"
    "36:33:57" = "Outro - Final thoughts"
}

# Convert time string to seconds
function ConvertToSeconds($time) {
    $parts = $time -split ":"
    return [int]$parts[0] * 3600 + [int]$parts[1] * 60 + [int]$parts[2]
}

# Convert seconds back to HH:mm:ss format
function ConvertToTimeFormat($totalSeconds) {
    $hours = [int]($totalSeconds / 3600)
    $minutes = [int](($totalSeconds % 3600) / 60)
    $seconds = $totalSeconds % 60
    return "{0:D2}:{1:D2}:{2:D2}" -f $hours, $minutes, $seconds
}

# Convert keys of $chapters hashtable to an array of timestamps
$timestampArray = $chapters.Keys | Sort-Object

# Iterate through each timestamp and create video segments
for ($i = 0; $i -lt $timestampArray.Count; $i++) {
    $startTime = $timestampArray[$i]
    $title = $chapters[$startTime]

    # Sanitize the title to create a valid filename (remove or replace special characters)
    $sanitizedTitle = $title -replace '[^a-zA-Z0-9_\-]', '_'
    $index = "{0:D2}" -f ($i + 1)
    $outputFile = "${index}-${sanitizedTitle}.mp4"

    if ($i -lt $timestampArray.Count - 1) {
        # Set the end time to the next chapter's start time
        $endTime = $timestampArray[$i + 1]
    } else {
        # For the last chapter, don't specify the end time (i.e., go to the end of the video)
        $endTime = $null
    }

    # Convert times to seconds for calculations
    $startTimeInSeconds = ConvertToSeconds($startTime)

    if ($endTime) {
        $endTimeInSeconds = ConvertToSeconds($endTime)
        $durationInSeconds = $endTimeInSeconds - $startTimeInSeconds
        # Create segment with a specified duration
        ffmpeg -i $input -ss $startTime -t $durationInSeconds -c copy $outputFile
    } else {
        # Create the last segment that goes to the end of the video
        ffmpeg -i $input -ss $startTime -c copy $outputFile
    }
}
