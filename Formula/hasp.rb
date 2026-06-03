class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.34"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.34/hasp_1.0.34_darwin_arm64.tar.gz"
      sha256 "a8ba97df68398b87642997052fd26bd27fa49251bc25a3bc6bbd819580cfd77f"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.34/hasp_1.0.34_darwin_amd64.tar.gz"
      sha256 "23c08a313dc289ff59a40fb91e56d572a869a515e44774e79bc8bdd854dbaee3"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.34/hasp_1.0.34_linux_arm64.tar.gz"
      sha256 "6d35f3e3b984e460e95b80c41db591daf40655c911ab44a3afcc82e3042d5f70"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.34/hasp_1.0.34_linux_amd64.tar.gz"
      sha256 "06362bffc94277f1f4b575f03f6063da13b5581b3b0a6d11c7f0fde3aedd66a3"
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
