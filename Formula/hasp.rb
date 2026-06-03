class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.33"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.33/hasp_1.0.33_darwin_arm64.tar.gz"
      sha256 "ed7a4da0c0255a8928db6f2db394ae75196edad057cb520fc758eb11d4542914"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.33/hasp_1.0.33_darwin_amd64.tar.gz"
      sha256 "40152e67d0f649e3e60da1e35d6fcfc38d19e8db6fa0cce163657152bc2e19d0"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.33/hasp_1.0.33_linux_arm64.tar.gz"
      sha256 "51d65bab162366c08a1b773be48a665c6f527f35db9abcc6366ef93517cc1d02"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.33/hasp_1.0.33_linux_amd64.tar.gz"
      sha256 "d9eefa4b3d1e3db54c098ed0e26c3706f593d4d113fe9e5f32bca739a1df02a5"
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
