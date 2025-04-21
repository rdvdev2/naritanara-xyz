{
  name = "port-option";
  
  nodes.machine = {
    imports = [ ../static-web-server.nix ];
    
    services.naritanara-xyz = {
      enable = true;
      port = 8080;
    };
    
    system.stateVersion = "24.11";
  };
  
  testScript = ''
    machine.wait_for_open_port(8080)
    machine.succeed("curl localhost:8080 | grep naritanara.xyz")
    machine.fail("curl localhost:80")
  '';
}