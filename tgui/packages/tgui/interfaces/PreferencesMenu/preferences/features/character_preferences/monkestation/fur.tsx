import { Feature, FeatureValueProps, StandardizedPalette } from '../../base';

const furPresets = {
  // these need to be short color (3 byte) compatible
  '#ffffff': 'Albino',
  '#ffb089': 'Chimp',
  '#aeafb3': 'Grey',
  '#bfd0ca': 'Snow',
  '#ce7d54': 'Orange',
  '#c47373': 'Red',
  '#f4e2d5': 'Cream',
  // Rattus Colors v v v
  '#494949': 'Grey-1',
  '#565656': 'Grey-2',
  '#606060': 'Grey-3',
  '#606060': 'Grey-4',
  '8A8A8A': 'Grey-5',
  'B0B0B0': 'Grey-6',
  'C6C6C6': 'Grey-7',
  '#274554': 'Blue-1',
  '#38505B': 'Blue-2',
  '#4A606B': 'Blue-3',
  '#596C76': 'Blue-4',
  '#79919D': 'Blue-5',
  '#8EA6B1': 'Blue-6',
  '#AFC6D1': 'Blue-7',
  '#511400': 'Orange-1',
  '#5B1600': 'Orange-2',
  '#681A00': 'Orange-3',
  '#7A2000': 'Orange-4',
  '#962800': 'Orange-5',
  '#A82700': 'Orange-6',
  '#CE3E06': 'Orange-7',
  '#44220D': 'Brown-1',
  '#562B10': 'Brown-2',
  '#723915': 'Brown-3',
  '#874319': 'Brown-4',
  '#9E4F1E': 'Brown-5',
  '#C16024': 'Brown-6',
  '#D86C29': 'Brown-7',
  '#204424': 'Green-1',
  '#27542C': 'Green-2',
  '#27632D': 'Green-3',
  '#27632D': 'Green-4',
  '#437F49': 'Green-5',
  '#45964D': 'Green-6',
  '#47A550': 'Green-7',
};

export const fur: Feature<string> = {
  name: 'Fur Color',
  small_supplemental: false,
  predictable: false,
  component: (props: FeatureValueProps<string>) => {
    const { handleSetValue, value, featureId, act } = props;

    return (
      <StandardizedPalette
        choices={Object.keys(furPresets)}
        displayNames={furPresets}
        onSetValue={handleSetValue}
        value={value}
        hex_values
        featureId={featureId}
        act={act}
        maxWidth="100%"
        includeHex
      />
    );
  },
};
