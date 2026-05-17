class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.20"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.20/hasp_1.0.20_darwin_arm64.tar.gz"
      sha256 "d40a94151cd79872b02d229640d7fb5cb93b7f9bfdcc4b92cd328f26309fb299"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.20/hasp_1.0.20_darwin_amd64.tar.gz"
      sha256 "2fedda6d52888017f25703d99e12db02f2173fe2f6d03cca9cfc7dc1a86cbeb0"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.20/hasp_1.0.20_linux_arm64.tar.gz"
      sha256 "1cb670ea05a61017db4c20adf4d740f741d61194294b2cc062277b994ee850ef"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.20/hasp_1.0.20_linux_amd64.tar.gz"
      sha256 "a2817e6c7348a33aa026d3ee9f4cc13c7fb0d994f08fbafb8138abb0246fcb98"
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
