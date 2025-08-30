local file = io.open("version.yaml", "w")
if file then
    file:write("version: \"1.0.0\"")
    
    file:close()
    
    print("Successfully created 'version.yaml'")
else
    print("Error: Could not open the file for writing.")
end
