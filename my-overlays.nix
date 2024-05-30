#this should be temporary as for now default jdk is 21 and it deprecated source 7
final: prev: {
  mu = prev.mu.overrideAttrs (old: {
    version = "1.10.8";
    src = prev.fetchFromGitHub {
      owner = "djcb";
      repo = "mu";
      rev = "v1.10.8";
      hash = "sha256-cDfW0yXA+0fZY5lv4XCHWu+5B0svpMeVMf8ttX/z4Og=";
    };

    patches = [
      (prev.fetchpatch {
        name = "add-mu4e-pkg.el";
        url = "https://github.com/djcb/mu/commit/00f7053d51105eea0c72151f1a8cf0b6d8478e4e.patch";
        hash = "sha256-21c7djmYTcqyyygqByo9vu/GsH8WMYcq8NOAvJsS5AQ=";
      })
    ];
    postPatch = ''
      # Fix mu4e-builddir (set it to $out)
      substituteInPlace mu4e/mu4e-config.el.in \
        --replace "@abs_top_builddir@" "$out"
      substituteInPlace lib/utils/mu-test-utils.cc \
        --replace "/bin/rm" "${prev.coreutils}/bin/rm"
    '';
  });
}
