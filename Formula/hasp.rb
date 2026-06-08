class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.35"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.35/hasp_1.0.35_darwin_arm64.tar.gz"
      sha256 "6aba0f52ec8e82e614ce9e6e5ee9633b8d530debcd9b198afff8ef61fe2f77c5"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.35/hasp_1.0.35_darwin_amd64.tar.gz"
      sha256 "bccaf00f0a5dcffad4487965af634b6462fa836db9ab0f64658884860a5754e8"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.35/hasp_1.0.35_linux_arm64.tar.gz"
      sha256 "b4ec338b26e9432e760f6037fed23f0ce1dff107594c024a16012c1ef4bb6ed8"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.35/hasp_1.0.35_linux_amd64.tar.gz"
      sha256 "a53398eb6ea89afa3f434482b502b4be3e3e8b86dcf815ebfd68f033e203985c"
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
