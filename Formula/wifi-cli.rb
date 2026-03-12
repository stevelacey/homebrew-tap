require "language/node"

class WifiCli < Formula
  desc "Command line utility for managing Wi-Fi connections on macOS"
  homepage "https://github.com/stevelacey/wifi-cli-macos"
  url "https://registry.npmjs.org/wifi-cli-macos/-/wifi-cli-macos-2.1.0.tgz"
  sha256 "c4c983aa42c47f6ec80f078a52104658d11853456eef11309ce3c9e00756e0b9"
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
