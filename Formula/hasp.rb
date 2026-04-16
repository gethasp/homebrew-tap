class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.2"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.2/hasp_0.1.2_darwin_arm64.tar.gz"
      sha256 "e72b7921d66d9d67d0a17a5f25b4896791e08abf2ff2c078f9969eaaf2fe34ba"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.2/hasp_0.1.2_darwin_amd64.tar.gz"
      sha256 "87be8729a1b460b19df908284119c0c1d2a3f99ce001f1fb4196ce78d27d7198"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.2/hasp_0.1.2_linux_arm64.tar.gz"
      sha256 "0f36e5b1f7f82a7b165fd558a659a7f2afc3a1beb4cca7eee68619754bf7a260"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.2/hasp_0.1.2_linux_amd64.tar.gz"
      sha256 "472a44b98f48204a53a1c8cdce63ee5f7b78139c8fc56e126e96c4ed717115b3"
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
