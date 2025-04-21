{
  name = "service";
  
  nodes.machine = {
    imports = [ ../static-web-server.nix ];
    
    services.naritanara-xyz.enable = true;
    
    system.stateVersion = "24.11";
  };
  
  testScript = ''
    machine.wait_for_open_port(80)
    machine.succeed("curl localhost:80 | grep naritanara.xyz")
  '';
}