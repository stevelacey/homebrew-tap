cask "proton-vpn-menubar" do
  version "1.2.4"
  sha256 "57cd3e07eee7c9aee4d8a7bb4086c7eb73c2456acbdfcf8b54215f4527e5323a"

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
