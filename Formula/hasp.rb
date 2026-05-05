class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.4"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.4/hasp_1.0.4_darwin_arm64.tar.gz"
      sha256 "4bcbf1f6b029b62dd7597bc481034c6b4e224bf520bec1376d34d10f391a287d"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.4/hasp_1.0.4_darwin_amd64.tar.gz"
      sha256 "f4c72c524c1adf617b9e8ce706137dbf5b42fdff4ad05163252968523ed6af39"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.4/hasp_1.0.4_linux_arm64.tar.gz"
      sha256 "41fefbf7123297a2269e14eb4879dff053097a48678715e084561ed2a26d1a31"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.4/hasp_1.0.4_linux_amd64.tar.gz"
      sha256 "aae28898c184ed56219704863abf17eaa28269c96da1bfc169da8b272af55b12"
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
