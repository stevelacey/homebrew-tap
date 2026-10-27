cask "proton-vpn-menubar" do
  version "1.1.0"
  sha256 "5cf2f9073699f3f37bf11bdc267f4c67e3550a4c9c364aafe6d1bdbbfdddf917"

  url "https://github.com/stevelacey/proton-vpn-menubar/releases/download/#{version}/ProtonVPNMenuBar-#{version}.zip"
  name "Proton VPN Menu Bar"
  desc "Menu bar app for Proton VPN, built on the Proton VPN CLI"
  homepage "https://github.com/stevelacey/proton-vpn-menubar"

  depends_on formula: "stevelacey/tap/proton-vpn-cli"
  depends_on macos: :sonoma

  app "Proton VPN Menu Bar.app"

  # The app isn't signed with a Developer ID, so macOS won't open it while it's quarantined.
  postflight_steps do
    run "/usr/bin/xattr", args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Proton VPN Menu Bar.app"],
                          writable_paths: ["Proton VPN Menu Bar.app"],
                          writable_base:  :appdir
  end

  uninstall quit: "com.stevelacey.proton-vpn-menubar"

  zap trash: "~/Library/Preferences/com.stevelacey.proton-vpn-menubar.plist"
end
