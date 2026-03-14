require "language/node"

class WifiCli < Formula
  desc "Command line utility for managing Wi-Fi connections on macOS"
  homepage "https://github.com/stevelacey/wifi-cli-macos"
  url "https://registry.npmjs.org/wifi-cli-macos/-/wifi-cli-macos-2.2.0.tgz"
  sha256 "cfa3c5a6f0349697686d3fc2c9ed751e7a7f5d7a49cf6128d61b73185561b13b"
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
