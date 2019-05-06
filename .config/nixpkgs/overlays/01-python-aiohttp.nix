self: super: {
  python37 = with super; super.python37.override {
    packageOverrides = python-self: python-super: {
      aiohttp = python-super.aiohttp.overrideAttrs (oldAttrs: {
        doInstallCheck = !stdenv.isDarwin;
        # doCheck = !stdenv.isDarwin;
      });
    };
  };
}
