New-VM -Name 'DC01' `
-Generation 2 `
-MemoryStartupBytes '2048MB' `
-NewVHDPath 'C:\Hyper-V\Virtual hard disks\DC01.vhdx' `
-NewVHDSizeBytes '40GB' `
-BootDevice 'CD'

