cask "battery-toolkit" do
  arch arm: "arm64"

  version "1.6"
  sha256 "1a4d99b55e49b69465f526d783de8a2fa5e1648394989f6c8328ccd9d4b0d73f"

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
