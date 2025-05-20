cask "battery-toolkit" do
  arch arm: "arm64"

  version "1.7"
  sha256 "85587f9e467bd9c42b82427a6a1a09108f5c003ce603629955cc2dfb10aff951"

  url "https://github.com/mhaeuser/Battery-Toolkit/releases/download/#{version}/Battery-Toolkit-#{version}.zip"
  name "Battery Toolkit"
  desc "Control the platform power state of your Apple Silicon device"
  homepage "https://github.com/mhaeuser/Battery-Toolkit/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Battery Toolkit.app"

  uninstall_preflight do
    system "sudo", "security", "authorizationdb", "remove", "me.mhaeuser.batterytoolkitd.manage"
  end

  uninstall launchctl:  "me.mhaeuser.batterytoolkitd",
            quit:       "me.mhaeuser.BatteryToolkit",
            login_item: "me.mhaeuser.BatteryToolkitAutostart",
            delete:     [
              "/Library/LaunchDaemons/me.mhaeuser.batterytoolkitd.plist",
              "/Library/PrivilegedHelperTools/me.mhaeuser.batterytoolkitd",
            ]

  zap trash: [
    "/var/root/Library/Preferences/me.mhaeuser.batterytoolkitd.plist",
    "~/Library/Preferences/me.mhaeuser.BatteryToolkit.plist",
  ]

  caveats <<~EOS
    This app will not work with quarantine attribute.
  EOS
end
