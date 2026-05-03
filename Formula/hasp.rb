class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.56"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.56/hasp_0.1.56_darwin_arm64.tar.gz"
      sha256 "75cbfff3db89ce4be2cb31b986605d8c2a6bc3dbb4c2d1d10b43002973cdc4aa"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.56/hasp_0.1.56_darwin_amd64.tar.gz"
      sha256 "5764a3de15dbff3c70f54b17bfcee9f1a60bf3b77726cba2eaf9a827178e770c"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.56/hasp_0.1.56_linux_arm64.tar.gz"
      sha256 "9f315f6663b5fb21fb10ec6c70299c1df3cc58889147024f8c84a337df6d2ca7"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.56/hasp_0.1.56_linux_amd64.tar.gz"
      sha256 "f6f9cc4cf69184896098ce6f6d8e2f4b85acc8ca97845406402994e8d622457d"
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
