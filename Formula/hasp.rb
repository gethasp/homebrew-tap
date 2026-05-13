class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.5"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.5/hasp_1.0.5_darwin_arm64.tar.gz"
      sha256 "8614f1a903d266eaa831623deb92403b7081a5ee7cb71a8dedeae8acd6cbfcb5"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.5/hasp_1.0.5_darwin_amd64.tar.gz"
      sha256 "2779f4149d399cc49eea708afe4aed59d927e2ce1be5b437c129ff38bb82f911"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.5/hasp_1.0.5_linux_arm64.tar.gz"
      sha256 "22bc96955eb52821c36f613843471acdb4d7d9e5c7466a6ad3260d95a587e8f5"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.5/hasp_1.0.5_linux_amd64.tar.gz"
      sha256 "9a276fc056559068bd2355b0822f434101a12d16ac1ecf6abde7024d94ec3dcf"
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
