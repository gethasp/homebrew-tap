class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.43"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.43/hasp_1.0.43_darwin_arm64.tar.gz"
      sha256 "2c70bf0bf6b0460b4682ebfe7461f72c2bf07d91e327d3132e27ffceade49556"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.43/hasp_1.0.43_darwin_amd64.tar.gz"
      sha256 "7dd61c396625770c283277dc45490e9fcd4440f23308d12be660cd98c925a42c"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.43/hasp_1.0.43_linux_arm64.tar.gz"
      sha256 "6af33a1a79ef40002f67b858960cc633e8c277423df21eac6daf268591b5efe5"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.43/hasp_1.0.43_linux_amd64.tar.gz"
      sha256 "e6df1fd4476557d57d4a20da8cfcb63251d0eba91b88d66ce702fe258a82dd73"
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
