class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.13"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.13/hasp_1.0.13_darwin_arm64.tar.gz"
      sha256 "b62ccfad9d0721678fb6fc5e9840b6ad7d62ab8f13f65b2ba42161625d51e6ae"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.13/hasp_1.0.13_darwin_amd64.tar.gz"
      sha256 "c36b76c58104895aae03928d9e28007753b675b73ba030d52155fb4f605698b3"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.13/hasp_1.0.13_linux_arm64.tar.gz"
      sha256 "7d6ef2f2ac3cb1802dc564a741c781324b5323ab98bdee6073bda1b70d059e1e"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.13/hasp_1.0.13_linux_amd64.tar.gz"
      sha256 "4a10155b4dd4328f3b98ba6dc594c220e17eec48e2dcc63c62fa16687b1f0673"
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
