class ProtonVpnCli < Formula
  desc "Command-line client for Proton VPN on macOS"
  homepage "https://github.com/stevelacey/proton-vpn-cli-macos"
  url "https://github.com/stevelacey/proton-vpn-cli-macos/releases/download/1.2.0/proton_vpn_cli_macos-1.2.0-cp312-abi3-macosx_11_0_universal2.whl", using: :nounzip
  sha256 "0c8314f224724371c1ac0a79f600996e858b177138f6160cc06f4b4c61d05484"
  license "GPL-3.0-or-later"

  depends_on "bash"
  depends_on :macos
  depends_on "python@3.13"
  depends_on "wireguard-tools"

  def install
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", Dir["*.whl"].first
    bin.install_symlink libexec/"bin/protonvpn"
  end

  def caveats
    <<~EOS
      Set it up, which asks for your Mac password once so connecting doesn't need it,
      and signs you in to your Proton account:
        protonvpn setup
    EOS
  end

  test do
    assert_match "Proton VPN", shell_output("#{bin}/protonvpn help")
  end
end
