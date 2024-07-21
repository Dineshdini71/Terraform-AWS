Count Vs Foreach
When to use count & When to use Foreach
Count :  If you creating identical resource like virtual machine with an incremental value like Vm-1 Vm-2 Vm-3 count is a good choice
•	Count follows index values any change in the existing index will recreate all resources.
Foreach : For creating sub-resources like ingress in security groups rule in ALB which don’t need any index value foreach is good choice.
•	Foreach don’t follow any index. It doesn’t matter if you add value before or after in a list.
