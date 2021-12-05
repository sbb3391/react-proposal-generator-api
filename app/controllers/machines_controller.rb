class MachinesController < ApplicationController

  def show
    machine = Machine.find(params[:id])

    render json: machine, machine_id: params[:id]
  end

  def index
  end 

  def destroy
    machine = Machine.find(params[:id])
    machine.destroy

    render json: machine
  end
  
  def create
    
    if params[:proposal_id]
      proposal = Proposal.find(params[:proposal_id])
      machine = Machine.create(model_id: params[:model][:id], proposal_id: proposal.id, customer_id: proposal ? Customer.find(proposal.customer_id).id : nil)
    else
      proposal = Proposal.create(name: params[:model][:proposal_name], customer_id: params[:model][:customer_id])
      machine = Machine.create(model_id: params[:model][:id], proposal_id: proposal.id, customer_id: proposal ? Customer.find(proposal.customer_id).id : nil)
    end

    image_items = []

    params[:model][:assemblies].each do |assembly|
      assembly_id = assembly[:id]

      assembly[:items].each do |item| 
        assembly_item = ItemsAssembly.find_by(assembly_id: assembly_id, item_id: item[:itemId])
        i = Item.find_by(id: assembly_item.item_id)
        i.image ? image_items.push(i.id) : nil
        machine.machine_assembly_items.build(assembly_item_id: assembly_item.id, unit_price: i.branch_floor_price )
      end
    end

    machine.save

    render json: machine, machine_id: machine.id
  end

  def update
    params[:assemblies].each do |assembly| 
      assembly[:items].each do |item|
        assembly_item_id =  ItemsAssembly.find_by(item_id: item[:itemId], assembly_id: item[:assemblyId]).id
        machine_assembly_item = MachineAssemblyItem.find_by(machine_id: item[:machineId], assembly_item_id: assembly_item_id)
        machine_assembly_item.update(unit_price: item[:unitPrice])
      end
    end

    machine_id = Machine.find(params[:machineId]).id
    machine = Machine.find(machine_id)
  
    render json: machine, machine_id: machine.id
  end

  def preview
    @machine = Machine.new(model_id: params[:model][:id])

    params[:model][:assemblies].each do |assembly|
      assembly_id = assembly[:id]

      assembly[:items].each do |item| 
        assembly_item = ItemsAssembly.find_by(assembly_id: assembly_id, item_id: item[:itemId])
        i = Item.find_by(id: assembly_item.item_id)
        @machine.machine_assembly_items.build(assembly_item_id: assembly_item.id, unit_price: i.branch_floor_price )
      end
    end

    x = @machine.machine_assembly_items.map do |mai|
      items_assembly = ItemsAssembly.find(mai.assembly_item_id)
      Item.find_by(id:items_assembly.item_id).description
    end

    render json: @machine, machine_id: @machine.id, serializer: MachinePreviewSerializer

  end
end
