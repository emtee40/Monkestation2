import { Feature, FeatureNumberInput } from '../base';

export const shadowcasting_darkness: Feature<number> = {
  name: 'Shadowcasting darkness',
  category: 'GAMEPLAY',
  description:
    'The density of darkness of turf shadows cast based on your location.',
  component: FeatureNumberInput,
};

export const shadowcasting_blurriness: Feature<number> = {
  name: 'Shadowcasting blurriness',
  category: 'GAMEPLAY',
  description:
    'The blurriness of darkness of turf shadows cast based on your location.',
  component: FeatureNumberInput,
};
