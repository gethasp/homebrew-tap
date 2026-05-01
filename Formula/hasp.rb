class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.39"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.39/hasp_0.1.39_darwin_arm64.tar.gz"
      sha256 "49259c588a47241de3862cb30e0b014d7de952da0622be37d11bc5b9cb1e5fcc"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.39/hasp_0.1.39_darwin_amd64.tar.gz"
      sha256 "033fe2ef052cbe8f7c4d4bba293d5eb761bc85c095d1c3e9c71001321192b9eb"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.39/hasp_0.1.39_linux_arm64.tar.gz"
      sha256 "b82b9bf878204978b2bacccbf1fd054000bef80a6067a46f87d7d015e524fd51"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.39/hasp_0.1.39_linux_amd64.tar.gz"
      sha256 "c495ca3638b988997be46f59d875143f05b8e94fe11543f30bd00ed58cb51602"
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
