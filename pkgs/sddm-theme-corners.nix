{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "sddm-theme-corners";
  version = "1.0";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "aczw";
    repo = "sddm-theme-corners";
    rev = "6ff0ff455261badcae36cd7d151a34479f157a3c";
    sha256 = "0iiasrbl7ciyhq3z02la636as915zk9ph063ac7vm5iwny8vgwh8";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes/sddm-theme-corners
    cp -r $src/corners/* $out/share/sddm/themes/sddm-theme-corners

    cd $out/share/sddm/themes/sddm-theme-corners
    rm theme.conf

    cat > theme.conf <<EOF
    ## Please see https://github.com/aczw/sddm-theme-corners/blob/main/CONFIG.md for
    ## more information about these options. Happy configuring!

    [General]

    # BgSource:     string. Path to an image, used as the wallpaper. Can be placed
    #               in the `backgrounds/` folder for convenience (see below!)
    #
    # FontFamily:   string. Name of the font family. You can find this with
    #               something like `fontconfig`, for example.
    #
    # FontSize:     number. This value is used for everything *except* the date/time.
    #
    # Padding:      number. How far away things should be from the edge of your screen.
    #
    # Radius:       number. Corner radius for UI. Set to 0 to disable rounded corners.
    #
    # Scale:        number. Adjusts the size of UI elements. Can be anything, but I
    #               would stick between 1 and 2 (e.g. 1.5).

    BgSource="backgrounds/glacier.png"
    FontFamily="Atkinson Hyperlegible"
    FontSize=9
    Padding=50
    Radius=10
    Scale=1

    # UserPictureEnabled:   boolean. By default the user picture is shown. Set to false
    #                       if you don't have/want a user picture, or you don't use the
    #                       user selection functionality.
    #
    # UserBorderWidth:      number. Width of the border around your picture. Set to
    #                       0 to remove.
    #
    # UserBorderColor:      color. Border color around your picture. Useless if border
    #                       width is 0.
    #
    # UserColor:            color. Background color of the default, blank avatar. Only
    #                       visible if you don't have your own picture.

    UserPictureEnabled=true
    UserBorderWidth=5
    UserBorderColor="#a080ff"
    UserColor="#cdd6f4"

    # InputColor:           color. Background color of the input fields.
    #
    # InputTextColor:       color. Color of text you enter in the fields.
    #
    # InputBorderWidth:     number. Width of the border around the active field. Set
    #                       to 0 to remove.
    #
    # InputBorderColor:     color. Border color of active field. Useless if border
    #                       width is 0.
    #
    # UserPlaceholderText:  string. Placeholder text shown when user field is empty.
    #
    # PassPlaceholderText:  string. Placeholder text shown when user field is empty.
    #
    # HidePassword:         boolean. Whether to replace your entered password with dots.

    InputColor="#1e1e2e"
    InputTextColor="#cdd6f4"
    InputBorderWidth=4
    InputBorderColor="#a080ff"
    UserPlaceholderText="user"
    PassPlaceholderText="password"
    HidePassword=true

    # LoginButtonTextColor:     color. Text color on the login button.
    #
    # LoginButtonText:          string. Text displayed on the button.
    #
    # LoginButtonColor:         color. Background color of the button.

    LoginButtonTextColor="#1e1e2e"
    LoginButtonText="Login"
    LoginButtonColor="#a080ff"

    # PopupColor:               color. Background color of popup window.
    #
    # PopupActiveColor:         color. Color around the currently selected entry.
    #
    # PopupActiveTextColor:     color. Text color of the currently selected entry.
    #                           Mainly provided for potential contrast issues.

    PopupColor="#a080ff"
    PopupActiveColor="#1e1e2e"
    PopupActiveTextColor="#cdd6f4"

    # SessionButtonColor:   color. Session button background color.
    #
    # SessionIconColor:     color. Color of the icon inside the session button.
    #
    # PowerButtonColor:     color. Power button background color.
    #
    # PowerIconColor:       color. Color of the icon inside the power button.

    SessionButtonColor="#a080ff"
    SessionIconColor="#1e1e2e"
    PowerButtonColor="#a080ff"
    PowerIconColor="#1e1e2e"

    # DateTimeSpacing:      number. Spacing between the date and time.
    #
    # Date/TimeColor:       color. Date/time text color.
    #
    # Date/TimeSize:        number. Font size for the date/time.
    #
    # Date/TimeIsBold:      boolean. Whether date/time text should be bolded.
    #
    # Date/TimeOpacity:     number. Date/time text opacity.
    #
    # Date/TimeFormat:      string. Change the format of how the date and time is displayed.
    #                       Note that they use different formats.

    DateTimeSpacing=-20

    DateColor="#cdd6f4"
    DateSize=36
    DateIsBold=false
    DateOpacity=1.0
    DateFormat="dddd, MMMM d"

    TimeColor="#cdd6f4"
    TimeSize=48
    TimeIsBold=true
    TimeOpacity=1.0
    TimeFormat="hh:mm AP"
    EOF
  '';
}
