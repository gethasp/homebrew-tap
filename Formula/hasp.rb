class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.38"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.38/hasp_1.0.38_darwin_arm64.tar.gz"
      sha256 "5794ef57245506c2ad6472df50af34883626356edec14af467e1f2020806d2fd"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.38/hasp_1.0.38_darwin_amd64.tar.gz"
      sha256 "3cb8dfa16e446ab78682f2852c9cb20b60715ea5cade0c3a35b9f43b719b5de7"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.38/hasp_1.0.38_linux_arm64.tar.gz"
      sha256 "f6f1df5c11e04c6312dc57cdc6e65f5375226d047dc5008476e8b404680c2b23"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.38/hasp_1.0.38_linux_amd64.tar.gz"
      sha256 "01693b4d6ada7ed34251499784472fe96e8a9a01b2eb6f3e13c2ff95662cbf74"
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
