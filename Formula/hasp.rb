class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.48"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.48/hasp_1.0.48_darwin_arm64.tar.gz"
      sha256 "827dee14bdf876bc365c5bd65a58b4cf1a3b3df13b771adf7be61e44224efd14"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.48/hasp_1.0.48_darwin_amd64.tar.gz"
      sha256 "9a2fce52fb245978e4614e959cd948e4d9c0354faacf44267f2e75483ce01fd3"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.48/hasp_1.0.48_linux_arm64.tar.gz"
      sha256 "b55573b4637f18cb69e3cd3596a5374290e098853f93fd9ac0be7fdd3b5d347b"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.48/hasp_1.0.48_linux_amd64.tar.gz"
      sha256 "8f3a2a10e2d9f78c44f9137a9a604e2299e01d059696e6d43f4d96b855c527bb"
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
