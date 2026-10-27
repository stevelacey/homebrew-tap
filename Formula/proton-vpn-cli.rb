class ProtonVpnCli < Formula
  desc "Command-line client for Proton VPN on macOS"
  homepage "https://github.com/stevelacey/proton-vpn-cli-macos"
  url "https://github.com/stevelacey/proton-vpn-cli-macos/releases/download/0.1.0/proton_vpn_cli_macos-0.1.0-cp312-abi3-macosx_11_0_universal2.whl", using: :nounzip
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "GPL-3.0-or-later"

  depends_on "bash"
  depends_on :macos
  depends_on "python@3.13"
  depends_on "wireguard-tools"

  def install
    system Formula["python@3.13"].opt_bin/"python3.13", "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", Dir["*.whl"].first
    bin.install_symlink libexec/"bin/vpn", libexec/"bin/protonvpn"
  end

  def caveats
    <<~EOS
      Connecting needs root for WireGuard and the kill switch. Run this once,
      which asks for your password, so connecting doesn't again:
        vpn setup

      Then sign in:
        protonvpn signin <username>
    EOS
  end

  test do
    assert_match "Proton VPN", shell_output("#{bin}/vpn help")
  end
end
