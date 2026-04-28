class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.34"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.34/hasp_0.1.34_darwin_arm64.tar.gz"
      sha256 "591ba2d103b3b3ec537b9246f34e8d088ef69f2bd68bee7ab6a1d20c49aae28d"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.34/hasp_0.1.34_darwin_amd64.tar.gz"
      sha256 "e975b4e4ab04a88f12591c334bcc1a6fa43204c1d173c6eef7ffb618e163062b"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.34/hasp_0.1.34_linux_arm64.tar.gz"
      sha256 "5b5a5bf9e614dbfbf50a8b2c471032bcbe88134c0c9fa0ec887060482b2d434f"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.34/hasp_0.1.34_linux_amd64.tar.gz"
      sha256 "4efa33b003fe6e2fb63386a8e6e621dbc075c357bb41e0b622d5a9f3f98b88d6"
    end
  end
  def install
    libexec.install "bin"
    bin.install_symlink libexec/"bin/hasp"
    (pkgshare/"agent-profiles").install Dir["agent-profiles/*"]
    (pkgshare/"profiles").install Dir["profiles/*"]
    (pkgshare/"scripts").install Dir["scripts/*"]
    pkgshare.install "README.md", "QUICKSTART.md", "OPERATOR_GUIDE.md", "PRODUCTION_GUIDE.md", "RELEASE_MANIFEST", "LICENSE"
  end

  def caveats
    <<~EOS
      Add #{bin} to PATH if it is not already there.
      Set HASP_HOME and HASP_MASTER_PASSWORD before first use.
      Package docs and helper scripts are installed under: #{pkgshare}
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
