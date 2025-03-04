from gwf import Workflow
gwf = Workflow()
foo = gwf.target(
    name='foo',
    inputs={'A':['a1','a2'],'B':'b'},
    outputs={'C':['a1b','a2b'],'D':'d'},
    core=8,
    memory='6gb',
)

print(foo.options)