class ProtonVpnCli < Formula
  desc "Command-line client for Proton VPN on macOS"
  homepage "https://github.com/stevelacey/proton-vpn-cli-macos"
  url "https://github.com/stevelacey/proton-vpn-cli-macos/releases/download/1.2.1/proton_vpn_cli_macos-1.2.1-cp312-abi3-macosx_11_0_universal2.whl", using: :nounzip
  sha256 "8279fa20e702330bc9469065f0dcc638cf352c571d665c28be34e5593e6c9247"
  license "GPL-3.0-or-later"

  depends_on "bash"
  depends_on "gnupg"
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
