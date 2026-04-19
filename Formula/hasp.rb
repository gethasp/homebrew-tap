class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.25"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.25/hasp_0.1.25_darwin_arm64.tar.gz"
      sha256 "c887d67eb3f987e1445a6a7cc375bbbfd678b9161db12b8b2b27af9c47acbfcd"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.25/hasp_0.1.25_darwin_amd64.tar.gz"
      sha256 "3a7ef1007d9a16ff99fcd95760f8006299a08d50dfdd79611db6e0945c481604"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.25/hasp_0.1.25_linux_arm64.tar.gz"
      sha256 "9d51d0e7e616a683bf68c324ab2dde948634afb5a46e59248cc72e87eb1b299e"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.25/hasp_0.1.25_linux_amd64.tar.gz"
      sha256 "3d887b3b4d6591d93a33b9e2a231e3c7b52a29e0354cc412b35c6080ca74c739"
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
