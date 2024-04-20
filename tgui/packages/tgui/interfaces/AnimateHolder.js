import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';
import { Button, Input, Section, Collapsible, LabeledList, NumberInput, Dropdown } from '../components';
import { ButtonCheckbox } from '../components/Button';

export const AnimateHolder = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window title="Animate Holder" width={550} height={350}>
      <Window.Content>
        <AnimateSteps />
      </Window.Content>
    </Window>
  );
};

const AnimateSteps = (props, context) => {
  const { act, data } = useBackend(context);
  const { steps, easings } = data;
  return (
    <Section fill scrollable title="Animation Steps">
      {steps.map((step) => (
        <Collapsible
          key={step.index}
          title={'Step:' + (steps.indexOf(step) + 1)}>
          <LabeledList>
            <LabeledList.Item label="Time">
              <NumberInput
                width="45px"
                minValue={-1000}
                maxValue={1000}
                value={step.time ? step.time : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'time',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Loop Count">
              <NumberInput
                width="45px"
                minValue={-1000}
                maxValue={1000}
                value={step.loop ? step.loop : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'loop',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Pixel Y">
              <NumberInput
                width="45px"
                minValue={-1000}
                maxValue={1000}
                value={step.pixel_y ? step.pixel_y : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'pixel_y',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Pixel X">
              <NumberInput
                width="45px"
                minValue={-1000}
                maxValue={1000}
                value={step.pixel_x ? step.pixel_x : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'pixel_x',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Transform">
              <Transform step={steps.indexOf(step) + 1} />
            </LabeledList.Item>
            <LabeledList.Item label="Color">
              <Input
                value={step.color ? step.color : ''}
                width="90px"
                onInput={(e, value) =>
                  act('modify_step', {
                    variable: 'color',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Alpha">
              <NumberInput
                width="45px"
                minValue={0}
                maxValue={255}
                value={step.alpha ? step.alpha : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'alpha',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Maptext">
              <Input
                value={step.maptext ? step.maptext : ''}
                width="90px"
                onInput={(e, value) =>
                  act('modify_step', {
                    variable: 'maptext',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Maptext Y">
              <NumberInput
                width="45px"
                minValue={-1000}
                maxValue={1000}
                value={step.maptext_y ? step.maptext_y : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'maptext_y',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Maptext X">
              <NumberInput
                width="45px"
                minValue={-1000}
                maxValue={1000}
                value={step.maptext_x ? step.maptext_x : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'maptext_x',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Maptext Width">
              <NumberInput
                width="45px"
                minValue={0}
                maxValue={1000}
                value={step.maptext_width ? step.maptext_width : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'maptext_width',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Maptext Height">
              <NumberInput
                width="45px"
                minValue={0}
                maxValue={1000}
                value={step.maptext_height ? step.maptext_height : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'maptext_height',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Layer">
              <NumberInput
                width="45px"
                minValue={-32700}
                maxValue={32700}
                value={step.layer ? step.layer : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'layer',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Luminosity">
              <NumberInput
                width="45px"
                minValue={-32700}
                maxValue={32700}
                value={step.luminosity ? step.luminosity : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'luminosity',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label="Direction">
              <NumberInput
                width="45px"
                minValue={0}
                maxValue={8}
                value={step.dir ? step.dir : 0}
                onChange={(_, value) =>
                  act('modify_step', {
                    variable: 'dir',
                    value: value,
                    index: steps.indexOf(step) + 1,
                  })
                }
              />
            </LabeledList.Item>
            <LabeledList.Item label={'Easing'}>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].LINEAR_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'LINEAR_EASING',
                    value: !easings[steps.indexOf(step)].LINEAR_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                LINEAR
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].SINE_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'SINE_EASING',
                    value: !easings[steps.indexOf(step)].SINE_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                SINE
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].CIRCULAR_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'CIRCULAR_EASING',
                    value: !easings[steps.indexOf(step)].CIRCULAR_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                CIRCULAR
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].QUAD_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'QUAD_EASING',
                    value: !easings[steps.indexOf(step)].QUAD_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                QUAD
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].CUBIC_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'CUBIC_EASING',
                    value: !easings[steps.indexOf(step)].CUBIC_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                CUBIC
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].BOUNCE_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'BOUNCE_EASING',
                    value: !easings[steps.indexOf(step)].BOUNCE_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                BOUNCE
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].ELASTIC_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'ELASTIC_EASING',
                    value: !easings[steps.indexOf(step)].ELASTIC_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                ELASTIC
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].BACK_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'BACK_EASING',
                    value: !easings[steps.indexOf(step)].BACK_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                BACK
              </ButtonCheckbox>
              <ButtonCheckbox
                checked={easings[steps.indexOf(step)].JUMP_EASING}
                onClick={() =>
                  act('modify_easing', {
                    flag: 'JUMP_EASING',
                    value: !easings[steps.indexOf(step)].JUMP_EASING,
                    index: steps.indexOf(step) + 1,
                  })
                }>
                JUMP
              </ButtonCheckbox>
            </LabeledList.Item>
          </LabeledList>
          <Button
            color="red"
            icon="sync"
            width="100%"
            onClick={() =>
              act('remove_step', { index: steps.indexOf(step) + 1 })
            }>
            Delete Step
          </Button>
        </Collapsible>
      ))}
      <Button
        color="green"
        icon="sync"
        width="100%"
        onClick={() => act('add_blank_step')}>
        Create New Step
      </Button>
    </Section>
  );
};

export const Transform = (props, context) => {
  const { step } = props;
  const { act, data } = useBackend(context);
  const { steps, easings } = data;
  let [type, setType] = useLocalState(context, 'type', '');
  let [val1, setVal1] = useLocalState(context, 'val1', 1);
  let [val2, setVal2] = useLocalState(context, 'val2', 1);
  const types = ['rotate', 'scale'];

  return (
    <Section>
      <Dropdown
        options={types}
        displayText={type}
        color="black"
        width="100%"
        onSelected={(selectedVal) => setType(selectedVal)}
      />
      <NumberInput
        width="45px"
        minValue={-1000}
        maxValue={1000}
        value={val1}
        onChange={(_, value) => setVal1(value)}
      />
      {type === 'scale' && (
        <NumberInput
          width="45px"
          minValue={-1000}
          maxValue={1000}
          value={val2}
          onChange={(_, value) => setVal2(value)}
        />
      )}
      <Button
        color="red"
        icon="sync"
        width="100%"
        onClick={() =>
          act('modify_transform', {
            matrix_type: type,
            value1: val1,
            value2: val2,
            index: step,
          })
        }>
        Confirm
      </Button>
    </Section>
  );
};
