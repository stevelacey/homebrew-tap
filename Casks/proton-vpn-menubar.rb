cask "proton-vpn-menubar" do
  version "1.2.5"
  sha256 "aa9171479d159a508ae145e56308eee62459f140e12e8f4fac3c5d81681a8c03"

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
