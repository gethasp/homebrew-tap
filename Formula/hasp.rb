class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.37"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.37/hasp_0.1.37_darwin_arm64.tar.gz"
      sha256 "2e17fa5ea556743ee47d207b4a785e08af812170ffb9ed8066d9b15aceb78a3a"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.37/hasp_0.1.37_darwin_amd64.tar.gz"
      sha256 "6479dce14e132a7ddeeb9bf9ad86cb2f8ebf1c4a1daa9326ebb4e118e5b5430c"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.37/hasp_0.1.37_linux_arm64.tar.gz"
      sha256 "a1fb6f2423eea40735a18711e5f6a5b2073e729d4e135bf10572fafa4477420e"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.37/hasp_0.1.37_linux_amd64.tar.gz"
      sha256 "c2503e225e87a8b097d1017bf5c20b69e21a6d99b024e75a87ec694068839bfd"
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
