import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Button, Input, Section, Collapsible, LabeledList, NumberInput } from '../components';
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
