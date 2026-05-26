class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.28"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.28/hasp_1.0.28_darwin_arm64.tar.gz"
      sha256 "acb1be04e4937408f8071fb1885145d88a1f50cdcae9d7bb70d6be2f1990c069"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.28/hasp_1.0.28_darwin_amd64.tar.gz"
      sha256 "46fe968de9a3a4178815249b8a4166022d34de5c794c0c826bf3f3e18ea54f5e"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.28/hasp_1.0.28_linux_arm64.tar.gz"
      sha256 "d111a7ddd0d78feb932858ff850dfa617cd31493955c342b886d10b9dbb2be63"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.28/hasp_1.0.28_linux_amd64.tar.gz"
      sha256 "2c229770468f73ea6e0a2eaeef88bcdf3b33711274642cacc670eccde35f647e"
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
      If hasp version does not print #{version}, run: which -a hasp
      Remove or reorder earlier stale binaries such as ~/.local/bin/hasp, then run: hash -r
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
