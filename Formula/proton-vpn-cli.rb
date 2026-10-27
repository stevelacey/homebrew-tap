class ProtonVpnCli < Formula
  desc "Command-line client for Proton VPN on macOS"
  homepage "https://github.com/stevelacey/proton-vpn-cli-macos"
  url "https://github.com/stevelacey/proton-vpn-cli-macos/releases/download/1.0.0/proton_vpn_cli_macos-1.0.0-cp312-abi3-macosx_11_0_universal2.whl", using: :nounzip
  sha256 "c433b5e70db58bb10a8f9819bcd6d1b3a521436a6a0430ee7ebd8b0d47f3aa58"
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
