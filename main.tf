resource "azurerm_resource_group" "vn" {
    name = var.rgname
    location = var.rglocation
  
}
resource "azurerm_virtual_network" "face123" {
    name = var.networkname
    address_space = var.address_space
    resource_group_name = var.rgname
    location = var.rglocation
    
  
}
resource "azurerm_subnet" "vn1" {
    name = var.subnetname
    resource_group_name = var.rgname
    virtual_network_name = var.networkname
    address_prefixes = var.address_prefixes_id

  
}
resource "azurerm_network_interface" "vn2" {
    name = var.networkinterfacename
    location = var.rglocation
    resource_group_name = var.rgname

    ip_configuration {
      name = var.ipconfigurationname
      subnet_id = var.address_prefixes_id
      private_ip_address_allocation = var.allocation
    }
  
}
  
resource "azurerm_windows_virtual_machine" "vn3" {
    name = var.vmname
    resource_group_name = var.rgname
    location = var.rglocation
    size = var.size
    admin_username = var.username
    admin_password = var.password
    network_interface_ids = [
        azurerm_network_interface.vn2.id,
      ]
  os_disk {
    caching = var.caching
    storage_account_type = var.storageaccounttype

  }
  source_image_reference {
    publisher = var.publisher
    offer = var.offer
    sku = var.sku
    version = var.vmversion
    
  }
}
