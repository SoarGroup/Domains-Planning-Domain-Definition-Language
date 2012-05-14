import os, sys

# locate the Python SML bindings and add to path
for d in os.environ.get('LD_LIBRARY_PATH', '').split(':'):
	if os.path.exists(os.path.join(d, '_Python_sml_ClientInterface.so')):
		sys.path.append(d)
import Python_sml_ClientInterface as sml

# add directories with common and domain-specific Python scripts to path
sys.path.extend(['python', 'output/blocks_world'])
from SmlCommandHandler import SmlCommandHandler
from bw__12step import bw__12step

def print_handler(id, data, agent, msg):
	print(msg.strip())

if __name__ == '__main__':
	kernel = sml.Kernel.CreateKernelInNewThread()
	agent = kernel.CreateAgent('s1')
	agent.RegisterForPrintEvent(sml.smlEVENT_PRINT, print_handler, None)

	# this registers output callback handlers to update the input
	# link when the agent sends commands to the output link
	SmlCommandHandler(bw__12step(agent), agent)

	agent.ExecuteCommandLine('source output/blocks_world/rules.soar')
	agent.ExecuteCommandLine('source pddl-base.soar')
	agent.ExecuteCommandLine('sp { indif (state <s> ^operator <o> +) --> (<s> ^operator <o> =) }')
	agent.ExecuteCommandLine('w --wmes')
	agent.ExecuteCommandLine('run 10')
