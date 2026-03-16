require "language/node"

class WifiCli < Formula
  desc "Command line utility for managing Wi-Fi connections on macOS"
  homepage "https://github.com/stevelacey/wifi-cli-macos"
  url "https://registry.npmjs.org/wifi-cli-macos/-/wifi-cli-macos-2.3.2.tgz"
  sha256 "00156da596ab8bfb3196713d90a516ad7aa249bd4ab2e482b44c500a9294f306"
  license "MIT"

  depends_on "node"
  depends_on :macos

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
    system "#{libexec}/lib/node_modules/wifi-cli-macos/build-scanner"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wifi --version")
  end
end
