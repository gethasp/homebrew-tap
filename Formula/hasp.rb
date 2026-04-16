class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "0.1.1"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.1/hasp_0.1.1_darwin_arm64.tar.gz"
      sha256 "c769be12cdd807e24b1fa60eaf872370af2e52ccae22efbedee87f83dfba7cb0"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.1/hasp_0.1.1_darwin_amd64.tar.gz"
      sha256 "793cce7963cdfdf1c670af69ea667064aae4bae7fa3fb0761dd7da799d39f834"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.1/hasp_0.1.1_linux_arm64.tar.gz"
      sha256 "396577708a1e5302ada041fee8df53df0ecf3bd18267820de0cffbba009b2ce3"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v0.1.1/hasp_0.1.1_linux_amd64.tar.gz"
      sha256 "4d141d0be5a60f9516885419df7881818db789022f8fbcb921e317baf59c0f6b"
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
