require "language/node"

class WifiCli < Formula
  desc "Command line utility for managing Wi-Fi connections on macOS"
  homepage "https://github.com/stevelacey/wifi-cli-macos"
  url "https://registry.npmjs.org/wifi-cli-macos/-/wifi-cli-macos-2.3.0.tgz"
  sha256 "4f3574c387c2c949d0c0c7641ee8cffa97bfb38676bab9cd1161b90b39caef08"
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
