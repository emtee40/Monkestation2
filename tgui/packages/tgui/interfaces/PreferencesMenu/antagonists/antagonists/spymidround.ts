import { multiline } from 'common/string';

import { Antagonist, Category } from '../base';

const MoleSleeperAgent: Antagonist = {
  key: 'molesleeperagent',
  name: 'Mole Sleeper Agent',
  description: [
    multiline`
      Your mission, should you choose to accept it: Infiltrate Space Station 13.
      Work yourself up the rankings as a member of their crew and steal vital equipment.
      Should you be caught or killed, your employer will disavow any knowledge
      of your actions. Good luck agent.
    `,

    multiline`
      Complete Spy Bounties to earn rewards from your employer.
      Use these rewards to sow chaos and mischief!
    `,
  ],
  category: Category.Midround,
};

export default MoleSleeperAgent;
