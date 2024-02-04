// THIS IS A MONKESTATION UI FILE

import { resolveAsset } from '../assets';
import { BooleanLike } from 'common/react';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Divider, Dropdown, Section, Stack, Tabs } from '../components';
import { Window } from '../layouts';

type Objective = {
  count: number;
  name: string;
  explanation: string;
  complete: BooleanLike;
  was_uncompleted: BooleanLike;
  reward: number;
};

type BorerInformation = {
  ability: AbilityInfo[];
};

type AbilityInfo = {
  ability_name: string;
  ability_explanation: string;
  ability_icon: string;
};

type Info = {
  objectives: Objective[];
};

const ObjectivePrintout = (props: any, context: any) => {
  const { data } = useBackend<Info>(context);
  const { objectives } = data;
  return (
    <Stack vertical>
      <Stack.Item bold>Your current objectives:</Stack.Item>
      <Stack.Item>
        {(!objectives && 'None!') ||
          objectives.map((objective) => (
            <Stack.Item key={objective.count}>
              #{objective.count}: {objective.explanation}
            </Stack.Item>
          ))}
      </Stack.Item>
    </Stack>
  );
};

export const AntagInfoBorer = (props: any, context: any) => {
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  return (
    <Window width={620} height={580} theme="ntos_cat">
      <Window.Content>
        <Tabs>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Introduction
          </Tabs.Tab>
          <Tabs.Tab
            icon="list"
            lineHeight="23px"
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Ability explanations
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <MainPage />}
        {tab === 2 && <BorerAbilities />}
      </Window.Content>
    </Window>
  );
};

const MainPage = () => {
  return (
    <Stack vertical fill>
      <Stack.Item minHeight="14rem">
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              You are a Cortical Borer, a creature that crawls into peoples
              ear&#39;s to then settle on the brain
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout />
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
      <Stack.Item minHeight="35rem">
        <Section fill title="Essentials">
          <Stack vertical>
            <Stack.Item>
              <span className={'color-red'}>Host and you</span>
              <br />
              <span>
                You depend on a host for survival and reproduction, you slowly
                regenerate your health whilst inside of a host but whilst
                outside of one you can be squished by anyone stepping onto you,
                killing you.
              </span>
              <br />
              <br />
              <span>
                When speaking, you will directly communicate to your host, by
                adding &quot; ; &quot; to the start of your message you will
                instead speak to the hivemind of all the borers
              </span>
              <br />
              <br />
              <span className={'color-red'}>
                Creating resources and their uses
              </span>
              <br />
              <br />
              <span>
                While inside of a host you will slowly generate internal
                chemicals, evolution points and chemical points.
              </span>
              <br />
              <br />
              <span>
                <span className={'color-red'}>Internal chemical points </span>
                are used for using most of the abilities, their main use is in
                injecting chemicals into your host using the chemical injector
              </span>
              <br />
              <br />
              <span>
                <span className={'color-red'}>Evolution points </span>
                are mostly used in the evolution tree and choosing your focus,
                both of those being essential to surviving and completing your
                objectives
              </span>
              <br />
              <br />
              <span>
                <span className={'color-red'}>Chemical evolution points </span>
                are used in learning new chemicals from your possible list of
                learn-able chemicals, along with learning chemicals from the
                hosts blood for both their benefit and your objectives
              </span>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

const BorerAbilities = (props: any, context: any) => {
  const { act, data } = useBackend<BorerInformation>(context);
  return (
    <Stack vertical fill>
      <Stack.Item minHeight="20rem">
        <AbilitySection />
      </Stack.Item>
    </Stack>
  );
};

const AbilitySection = (props: any, context: any) => {
  const { act, data } = useBackend<BorerInformation>(context);
  const { ability } = data;
  if (!ability) {
    return <Section minHeight="300px" />;
  }

  const [selectedAbility, setSelectedAbility] = useLocalState(
    context,
    'ability',
    ability[0]
  );

  return (
    <Section
      fill
      scrollable={!!ability}
      title="Abilities"
      buttons={
        <Button
          icon="info"
          tooltipPosition="left"
          tooltip={
            'Select an ability using the dropdown menu for an in-depth explanation.'
          }
        />
      }>
      <Stack>
        <Stack.Item grow>
          <Dropdown
            displayText={selectedAbility.ability_name}
            selected={selectedAbility.ability_name}
            width="100%"
            options={ability.map((abilities) => abilities.ability_name)}
            onSelected={(abilityName: string) =>
              setSelectedAbility(
                ability.find((p) => p.ability_name === abilityName) ||
                  ability[0]
              )
            }
          />
          {selectedAbility && (
            <Box
              position="absolute"
              height="12rem"
              as="img"
              src={resolveAsset(`borer.${selectedAbility.ability_icon}.png`)}
            />
          )}
          <Divider Vertical />
        </Stack.Item>
        <Stack.Divider />
        <Stack.Item scrollable grow={1} fontSize="16px">
          {selectedAbility && selectedAbility.ability_explanation}
        </Stack.Item>
      </Stack>
    </Section>
  );
};
